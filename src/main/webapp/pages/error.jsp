<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | System</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: #0f172a;
            color: #f1f5f9;
            font-family: 'Outfit', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }
        .container {
            padding: 3rem;
            background: rgba(30, 41, 59, 0.7);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 2rem;
            max-width: 500px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
        h1 { font-size: 4rem; margin: 0; color: #ef4444; }
        p { color: #94a3b8; font-size: 1.25rem; margin: 1.5rem 0; }
        .btn {
            display: inline-block;
            padding: 0.75rem 2rem;
            background: #6366f1;
            color: white;
            text-decoration: none;
            border-radius: 0.75rem;
            font-weight: 700;
            transition: 0.3s;
        }
        .btn:hover { background: #4f46e5; transform: scale(1.05); }
    </style>
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-exclamation-triangle"></i></h1>
        <p>${not empty error ? error : "An unexpected error occurred while processing your request."}</p>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn">Return to Dashboard</a>
    </div>
</body>
</html>
