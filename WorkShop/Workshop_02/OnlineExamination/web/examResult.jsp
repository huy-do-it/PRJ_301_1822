<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Exam Result</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }

        .result-container {
            max-width: 800px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        h2 {
            text-align: center;
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 30px;
            animation: fadeIn 1s ease-out 0.3s both;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .score {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            padding: 25px;
            background: linear-gradient(135deg, #48bb78, #38a169);
            color: white;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(72, 187, 120, 0.3);
            animation: pulse 2s infinite;
            position: relative;
            overflow: hidden;
        }

        .score::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: shine 3s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }

        @keyframes shine {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        hr {
            border: none;
            height: 2px;
            background: linear-gradient(90deg, transparent, #667eea, transparent);
            margin: 30px 0;
            animation: fadeIn 1s ease-out 0.5s both;
        }

        .question-block {
            margin-bottom: 25px;
            padding: 20px;
            background: #f8fafc;
            border-radius: 12px;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
            animation: slideInLeft 0.6s ease-out;
            animation-fill-mode: both;
            position: relative;
            overflow: hidden;
        }

        .question-block:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.2);
        }

        .question-block:nth-child(odd) {
            animation-delay: 0.1s;
        }

        .question-block:nth-child(even) {
            animation-delay: 0.2s;
        }

        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .question-block > div:first-child {
            font-weight: 600;
            font-size: 1.1rem;
            color: #2d3748;
            margin-bottom: 12px;
            line-height: 1.5;
        }

        .question-block > div:last-child {
            font-size: 1rem;
            color: #4a5568;
            padding: 12px 0;
            border-top: 1px solid #e2e8f0;
        }

        .correct {
            color: #38a169;
            font-weight: 600;
            padding: 4px 8px;
            background: rgba(72, 187, 120, 0.1);
            border-radius: 6px;
            position: relative;
        }

        .correct::before {
            content: '✓';
            margin-right: 5px;
            font-weight: bold;
        }

        .wrong {
            color: #e53e3e;
            font-weight: 600;
            padding: 4px 8px;
            background: rgba(229, 62, 62, 0.1);
            border-radius: 6px;
            position: relative;
        }

        .wrong::before {
            content: '✗';
            margin-right: 5px;
            font-weight: bold;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            padding: 15px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }

        .back-link:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .back-link::before {
            content: '←';
            margin-right: 8px;
            transition: transform 0.3s ease;
        }

        .back-link:hover::before {
            transform: translateX(-3px);
        }

        /* Score indicator based on performance */
        .score.excellent {
            background: linear-gradient(135deg, #48bb78, #38a169);
        }

        .score.good {
            background: linear-gradient(135deg, #ed8936, #dd6b20);
        }

        .score.poor {
            background: linear-gradient(135deg, #e53e3e, #c53030);
        }

        /* Progress bar for score */
        .score-progress {
            width: 100%;
            height: 8px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 4px;
            margin-top: 15px;
            overflow: hidden;
        }

        .score-progress-bar {
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 4px;
            transition: width 2s ease-out;
            animation: fillProgress 2s ease-out;
        }

        @keyframes fillProgress {
            from { width: 0%; }
        }

        /* Question numbering */
        .question-block::before {
            content: counter(question);
            counter-increment: question;
            position: absolute;
            top: -10px;
            left: 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 0.9rem;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .result-container {
            counter-reset: question;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .result-container {
                padding: 25px 20px;
                margin: 10px;
            }

            h2 {
                font-size: 2rem;
            }

            .score {
                font-size: 1.5rem;
                padding: 20px;
            }

            .question-block {
                padding: 15px;
                margin-bottom: 20px;
            }

            .back-link {
                padding: 12px 24px;
                font-size: 0.9rem;
            }
        }

        /* Celebration animation for high scores */
        .celebration {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1000;
        }

        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: #667eea;
            animation: confetti-fall 3s linear infinite;
        }

        @keyframes confetti-fall {
            0% {
                transform: translateY(-100vh) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }

        /* Loading animation */
        .loading {
            opacity: 0;
            animation: loadIn 0.6s ease-out forwards;
        }

        @keyframes loadIn {
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="result-container loading">
        <h2>Exam: ${exam.examTitle}</h2>
        <div class="score">
            Your Score: ${score} / ${total}
            <div class="score-progress">
                <div class="score-progress-bar" style="width: ${(score * 100) / total}%"></div>
            </div>
        </div>
        <hr/>
        <c:forEach var="q" items="${questions}" varStatus="loop">
            <div class="question-block">
                <div><b>Question ${loop.index + 1}:</b> ${q.questionText}</div>
                <div>
                    Your answer: 
                    <span class="${studentAnswers[q.questionId] == q.correctOption ? 'correct' : 'wrong'}">
                        ${studentAnswers[q.questionId]}
                    </span>
                    <c:if test="${studentAnswers[q.questionId] != q.correctOption}">
                        (Correct: <span class="correct">${q.correctOption}</span>)
                    </c:if>
                </div>
            </div>
        </c:forEach>
        <a href="ExamCategoriesController" class="back-link">Back to Dashboard</a>
    </div>

    <script>
        // Add score-based styling
        document.addEventListener('DOMContentLoaded', function() {
            const scoreElement = document.querySelector('.score');
            const scoreText = scoreElement.textContent;
            const [current, total] = scoreText.match(/(\d+) \/ (\d+)/).slice(1).map(Number);
            const percentage = (current / total) * 100;
            
            if (percentage >= 80) {
                scoreElement.classList.add('excellent');
                // Add confetti for excellent scores
                createConfetti();
            } else if (percentage >= 60) {
                scoreElement.classList.add('good');
            } else {
                scoreElement.classList.add('poor');
            }
        });

        function createConfetti() {
            const colors = ['#667eea', '#764ba2', '#48bb78', '#ed8936', '#e53e3e'];
            for (let i = 0; i < 50; i++) {
                const confetti = document.createElement('div');
                confetti.classList.add('confetti');
                confetti.style.left = Math.random() * 100 + '%';
                confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                confetti.style.animationDelay = Math.random() * 3 + 's';
                confetti.style.animationDuration = (Math.random() * 3 + 2) + 's';
                document.body.appendChild(confetti);
                
                setTimeout(() => confetti.remove(), 5000);
            }
        }
    </script>
</body>
</html>