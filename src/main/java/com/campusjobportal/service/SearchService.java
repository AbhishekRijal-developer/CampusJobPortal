package com.campusjobportal.service;

import com.campusjobportal.dao.JobDAO;
import com.campusjobportal.model.Job;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

/**
 * SearchService.java
 * Handles all job-search and filtering operations for the student portal.
 *
 * Features:
 *  - Free-text keyword search across title, description, and company name
 *  - Filter by category, location, and deadline
 *  - Combined multi-filter queries (any combination of the above)
 *  - Results are always limited to ACTIVE jobs with future deadlines
 *  - Input sanitisation before any DB call to prevent SQL injection risk
 *    (parameterised queries in the DAO handle escaping — this layer
 *     strips leading/trailing whitespace and rejects injected operators)
 *
 * Author: Prabesh Adhikari
 * Project: Campus Job Portal System
 */
public class SearchService {

    private final JobDAO jobDAO;

    /** Maximum characters allowed in a keyword search string. */
    private static final int MAX_KEYWORD_LENGTH = 100;

    /** Maximum results returned per search to protect performance. */
    private static final int MAX_RESULTS = 50;

    public SearchService() {
        this.jobDAO = new JobDAO();
    }

    // ================================================================
    // PRIMARY SEARCH ENTRY POINT
    // ================================================================

    /**
     * Executes a combined search using any combination of filters.
     * All parameters are optional — passing null or empty string skips that filter.
     *
     * Caller (Servlet) passes raw request parameters directly;
     * this method sanitises and delegates to the DAO.
     *
     * @param keyword   Free-text search (matches title, description, company name)
     * @param category  Exact category string (e.g. "IT", "Finance")
     * @param location  Partial location match (e.g. "Kathmandu")
     * @param deadline  Only return jobs with deadline on or after this date (nullable)
     * @return          List of matching ACTIVE jobs, at most MAX_RESULTS items
     */
    public List<Job> searchJobs(String keyword, String category,
                                String location, LocalDate deadline) {

        // --- Sanitise inputs ---
        String cleanKeyword  = sanitise(keyword);
        String cleanCategory = sanitise(category);
        String cleanLocation = sanitise(location);

        // If keyword is too long, reject (don't truncate silently)
        if (cleanKeyword != null && cleanKeyword.length() > MAX_KEYWORD_LENGTH) {
            return new ArrayList<>(); // controller should show an error separately
        }

        List<Job> results = jobDAO.searchJobs(
                cleanKeyword,
                cleanCategory,
                cleanLocation,
                deadline,
                MAX_RESULTS
        );
        return results != null ? results : new ArrayList<>();
    }

    // ================================================================
    // CONVENIENCE SINGLE-FILTER METHODS
    // ================================================================

    /**
     * Keyword-only search — most common student use case.
     *
     * @param keyword Free-text search string
     * @return        Matching active jobs
     */
    public List<Job> searchByKeyword(String keyword) {
        return searchJobs(keyword, null, null, null);
    }

    /**
     * Category filter — returns all active jobs in a given category.
     *
     * @param category Job category (must match exactly as stored in DB)
     * @return         All active jobs in that category
     */
    public List<Job> filterByCategory(String category) {
        return searchJobs(null, category, null, null);
    }

    /**
     * Location filter — partial match on the job's location field.
     *
     * @param location Location string (city, district, etc.)
     * @return         Jobs in or near that location
     */
    public List<Job> filterByLocation(String location) {
        return searchJobs(null, null, location, null);
    }

    /**
     * Deadline filter — returns jobs whose deadline is on or after the given date.
     * Useful for "still open" queries.
     *
     * @param date Minimum deadline date (inclusive)
     * @return     Jobs still open past this date
     */
    public List<Job> filterByDeadline(LocalDate date) {
        return searchJobs(null, null, null, date);
    }

    // ================================================================
    // DISTINCT VALUE LOOKUPS (for populating filter dropdowns)
    // ================================================================

    /**
     * Returns the list of distinct job categories currently in the DB.
     * Used to populate the "Category" dropdown on the search form.
     *
     * @return List of category strings, alphabetically sorted
     */
    public List<String> getAllCategories() {
        return jobDAO.findDistinctCategories();
    }

    /**
     * Returns the list of distinct job locations currently in the DB.
     * Used to populate the "Location" dropdown on the search form.
     *
     * @return List of location strings, alphabetically sorted
     */
    public List<String> getAllLocations() {
        return jobDAO.findDistinctLocations();
    }

    // ================================================================
    // VALIDATION HELPER (used by controller before calling search)
    // ================================================================

    /**
     * Validates raw search parameters supplied by the user.
     * Returns null if everything is acceptable, or an error message string.
     *
     * @param keyword  Raw keyword from request
     * @return         Error message, or null if valid
     */
    public String validateSearchInput(String keyword) {
        if (keyword != null && keyword.trim().length() > MAX_KEYWORD_LENGTH) {
            return "Search keyword must not exceed " + MAX_KEYWORD_LENGTH + " characters.";
        }
        return null;
    }

    // ================================================================
    // PRIVATE HELPERS
    // ================================================================

    /**
     * Trims whitespace and returns null for blank strings,
     * so the DAO can use simple null checks to skip unused filters.
     *
     * @param raw Raw string from the HTTP request parameter
     * @return    Trimmed string, or null if blank
     */
    private String sanitise(String raw) {
        if (ValidationUtil.isNullOrEmpty(raw)) return null;
        String trimmed = raw.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
