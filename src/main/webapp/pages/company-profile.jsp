<%@ page import="com.campusjobportal.model.Company" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>

<head>

  <meta charset="UTF-8">

  <title>Company Profile</title>

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <link rel="stylesheet"
        href="/CampusJobPortal/css/navbar.css">

  <link rel="stylesheet"
        href="/CampusJobPortal/css/company-profile.css">

</head>

<body>

<%@ include file="../includes/navbar.jsp" %>

<%
  Company company =
          (Company) request.getAttribute("company");
%>

<div class="company-container">

  <div class="company-card">

    <div class="company-header">

      <i class="fas fa-building"></i>

      <h1>Company Profile</h1>

    </div>

    <form action="/CampusJobPortal/CompanyProfileServlet"
          method="post">

      <input type="hidden"
             name="companyId"

             value="<%= company.getCompanyId() %>">

      <!-- COMPANY NAME -->

      <div class="form-group">

        <label>Company Name</label>

        <input type="text"
               name="companyName"

               value="<%= company.getCompanyName() %>"

               required>

      </div>

      <!-- DESCRIPTION -->

      <div class="form-group">

        <label>Description</label>

        <textarea name="description"
                  rows="5">

<%= company.getDescription() %>

                </textarea>

      </div>

      <!-- WEBSITE -->

      <div class="form-group">

        <label>Website</label>

        <input type="text"
               name="website"

               value="<%= company.getWebsite() %>">

      </div>

      <!-- INDUSTRY -->

      <div class="form-group">

        <label>Industry</label>

        <input type="text"
               name="industry"

               value="<%= company.getIndustry() %>">

      </div>

      <!-- LOCATION -->

      <div class="form-group">

        <label>Location</label>

        <input type="text"
               name="location"

               value="<%= company.getLocation() %>">

      </div>

      <!-- BUTTON -->

      <button type="submit"
              class="btn-save">

        <i class="fas fa-save"></i>

        Save Profile

      </button>

    </form>

  </div>

</div>

</body>
</html>