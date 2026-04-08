<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>VM-Code IDE | Cloud Editor</title>

    <!-- Main CSS -->
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <link rel="stylesheet" href="<c:url value='/css/ide.css'/>">

    <!-- Devicon Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/devicons/devicon@latest/devicon.min.css">

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

        body.home {
            font-family: var(--font-family);
            background: var(--bg-dark);
            background-image:
                radial-gradient(circle at 15% 50%, rgba(168, 85, 247, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 85% 30%, rgba(255, 255, 255, 0.05) 0%, transparent 50%);
            background-attachment: fixed;
            color: var(--text-primary);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        /* HERO SECTION */
        .hero {
            text-align: center;
            padding: 6rem 2rem 3rem;
            max-width: 800px;
            width: 100%;
            animation: fadeInDown 0.8s ease-out;
        }

        .hero h1 {
            font-size: clamp(2.5rem, 6vw, 4.5rem);
            font-weight: 800;
            line-height: 1.2;
            margin-bottom: 1.2rem;
            letter-spacing: -1px;
        }

        .hero h1 span {
            background: var(--gradient-text);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            font-size: clamp(1.1rem, 2vw, 1.4rem);
            color: var(--text-secondary);
            margin-bottom: 3rem;
            font-weight: 300;
        }

        .search-container {
            position: relative;
            max-width: 500px;
            margin: 0 auto;
        }

        .search-box {
            width: 100%;
            padding: 1.2rem 1.5rem 1.2rem 3.5rem;
            font-size: 1.1rem;
            border-radius: 50px;
            border: 1px solid var(--border-color);
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
            outline: none;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            font-family: var(--font-family);
        }

        .search-box:focus {
            border-color: var(--primary-accent);
            box-shadow: 0 0 20px rgba(168, 85, 247, 0.3);
            background: rgba(255, 255, 255, 0.08);
        }

        .search-icon {
            position: absolute;
            left: 1.4rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 1.2rem;
            pointer-events: none;
        }

        /* CATEGORIES */
        .categories {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
            margin-bottom: 3.5rem;
            padding: 0 1rem;
            animation: fadeIn 1s ease-out 0.3s both;
        }

        .categories button {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            padding: 0.7rem 1.8rem;
            border-radius: 30px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(5px);
            font-family: var(--font-family);
        }

        .categories button:hover, .categories button.active {
            background: var(--primary-accent);
            border-color: var(--primary-accent);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(168, 85, 247, 0.4);
        }

        /* GRID */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1.5rem;
            width: 100%;
            max-width: 1100px;
            padding: 0 2rem 5rem;
            animation: fadeInUp 1s ease-out 0.5s both;
        }

        .card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 2.5rem 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 1.5rem;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
            text-decoration: none;
            color: var(--text-primary);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .card:hover {
            transform: translateY(-10px) scale(1.02);
            border-color: rgba(255, 255, 255, 0.3);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.6), 0 0 25px rgba(168, 85, 247, 0.2);
        }

        .card:hover::before {
            opacity: 1;
        }

        .card i {
            font-size: 4.5rem;
            transition: transform 0.4s ease;
            filter: drop-shadow(0 4px 6px rgba(0,0,0,0.5));
        }

        .card:hover i {
            transform: scale(1.15) rotate(-5deg);
        }

        .card span {
            font-size: 1.3rem;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        /* ANIMATIONS */
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* MOBILE RESPONSIVE TWEAKS */
        @media (max-width: 768px) {
            .hero {
                padding: 4rem 1.5rem 2rem;
            }
            .grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 1.2rem;
                padding: 0 1.5rem 4rem;
            }
            .card {
                padding: 2rem 1rem;
                border-radius: 20px;
            }
            .card i {
                font-size: 3.5rem;
            }
            .card span {
                font-size: 1.1rem;
            }
            .search-box {
                font-size: 1rem;
            }
        }

        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 3rem;
            color: var(--text-secondary);
            font-size: 1.2rem;
            display: none;
        }
    </style>
</head>

<body class="home">

<!-- HERO -->
<div class="hero">
    <h1>Code online with <span>VM Code</span></h1>
    <p>Write, Run and Debug code instantly in your browser</p>

    <div class="search-container">
        <!-- SVG Search Icon -->
        <svg class="search-icon" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
        </svg>
        <input type="text" id="searchInput" placeholder="Search language... (e.g., Python, Java)" class="search-box">
    </div>
</div>

<!-- CATEGORY -->
<div class="categories">
    <button class="active" onclick="filterCategory('all', this)">Popular</button>
    <button onclick="filterCategory('programming', this)">Programming</button>
    <button onclick="filterCategory('web', this)">Web</button>
    <button onclick="filterCategory('database', this)">Database</button>
</div>

<!-- GRID -->
<div class="grid" id="languageGrid">

    <div class="card programming" onclick="openIDE('python')">
        <i class="devicon-python-plain colored"></i>
        <span>Python</span>
    </div>

    <div class="card programming" onclick="openIDE('java')">
        <i class="devicon-java-plain colored"></i>
        <span>Java</span>
    </div>

    <div class="card programming" onclick="openIDE('c')">
        <i class="devicon-c-plain colored"></i>
        <span>C</span>
    </div>
    <div class="card web" onclick="openIDE('html')">
        <i class="devicon-react-original colored"></i>
        <span>UI ENGINE</span>
    </div>

    <div class="card database" onclick="openIDE('mysql')">
        <i class="devicon-mysql-plain colored"></i>
        <span>MySQL</span>
    </div>

    <div class="empty-state" id="emptyState">
        No languages found matching your search.
    </div>
</div>

<!-- SCRIPT -->
<script>
    document.getElementById("searchInput").addEventListener("keyup", function () {
        let value = this.value.toLowerCase();
        let cards = document.querySelectorAll(".card");
        let hasVisibleCards = false;

        cards.forEach(card => {
            let text = card.innerText.toLowerCase();
            if (text.includes(value)) {
                card.style.display = "flex";
                hasVisibleCards = true;
            } else {
                card.style.display = "none";
            }
        });

        document.getElementById("emptyState").style.display = hasVisibleCards ? "none" : "block";
    });

    function filterCategory(category, btnElement) {
        let cards = document.querySelectorAll(".card");
        let hasVisibleCards = false;

        // Update active button state
        document.querySelectorAll(".categories button").forEach(btn => btn.classList.remove("active"));
        btnElement.classList.add("active");

        // Clear search
        document.getElementById("searchInput").value = "";

        cards.forEach(card => {
            if (category === "all" || card.classList.contains(category)) {
                card.style.display = "flex";
                hasVisibleCards = true;
            } else {
                card.style.display = "none";
            }
        });

        document.getElementById("emptyState").style.display = hasVisibleCards ? "none" : "block";
    }

    function openIDE(lang) {
        window.location.href = "/VM-code/ide?lang=" + lang;
    }
</script>
</body>
</html>