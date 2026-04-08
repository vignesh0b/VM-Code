<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>VM-Code IDE | Register</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <!-- Mobile responsive -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        :root {
            --bg-dark: #000000;
            --bg-card: rgba(20, 20, 25, 0.7);
            --text-primary: #ffffff;
            --text-secondary: #a1a1aa;
            --primary-accent: #a855f7;
            --gradient-text: linear-gradient(135deg, #ffffff 0%, #a855f7 100%);
            --border-color: rgba(255, 255, 255, 0.15);
            --font-family: 'Outfit', sans-serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--font-family);
            background: var(--bg-dark);
            background-image:
                radial-gradient(circle at 15% 50%, rgba(168, 85, 247, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 85% 30%, rgba(255, 255, 255, 0.05) 0%, transparent 50%);
            background-attachment: fixed;
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-container {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 3rem 2.5rem;
            width: 100%;
            max-width: 450px;
            text-align: center;
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6), 0 0 25px rgba(168, 85, 247, 0.1);
            animation: fadeInUp 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255,255,255,0.05) 0%, rgba(255,255,255,0) 100%);
            pointer-events: none;
        }

        .login-header h2 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            letter-spacing: -1px;
            background: var(--gradient-text);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .login-header p {
            color: var(--text-secondary);
            font-size: 1.1rem;
            margin-bottom: 2.5rem;
            font-weight: 300;
        }

        .input-group {
            margin-bottom: 1.5rem;
            text-align: left;
        }

        .input-group input {
            width: 100%;
            padding: 1rem 1.2rem;
            font-size: 1rem;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
            outline: none;
            transition: all 0.3s ease;
            font-family: var(--font-family);
        }

        .input-group input:focus {
            border-color: var(--primary-accent);
            box-shadow: 0 0 15px rgba(168, 85, 247, 0.2);
            background: rgba(255, 255, 255, 0.08);
        }

        .submit-btn {
            width: 100%;
            background: var(--primary-accent);
            color: white;
            padding: 1rem;
            font-size: 1.1rem;
            font-weight: 600;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: var(--font-family);
            margin-top: 1rem;
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(168, 85, 247, 0.4);
            background: #b266ff;
        }

        .error-msg {
            color: #ef4444;
            margin-top: 1.5rem;
            font-size: 0.95rem;
            font-weight: 400;
            background: rgba(239, 68, 68, 0.1);
            padding: 0.75rem;
            border-radius: 8px;
            border: 1px solid rgba(239, 68, 68, 0.2);
            display: none;
        }

        .register-link {
            margin-top: 2rem;
            color: var(--text-secondary);
            font-size: 1rem;
        }

        .register-link a {
            color: var(--primary-accent);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .register-link a:hover {
            color: #c084fc;
            text-decoration: underline;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @media (max-width: 480px) {
            .login-container {
                padding: 2.5rem 1.5rem;
            }
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-header">
        <h2>Create Account</h2>
        <p>Join VM-Code to start coding</p>
    </div>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <div class="input-group">
            <input type="text" name="username" placeholder="Username" required/>
        </div>
        <div class="input-group">
            <input type="password" name="password" placeholder="Password" required/>
        </div>

        <button type="submit" class="submit-btn">Register</button>
    </form>

    <c:if test="${not empty param.error}">
        <div class="error-msg" style="display: block;">
            Registration failed or username already exists
        </div>
    </c:if>

    <div class="register-link">
        Already have an account? <a href="${pageContext.request.contextPath}/login">Login</a>
    </div>
</div>
</body>
</html>