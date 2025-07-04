<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Take Exam - Online Exam System</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
            color: #333;
        }

        .floating-shapes {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: -1;
        }

        .floating-shapes::before,
        .floating-shapes::after {
            content: '';
            position: absolute;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            animation: float 6s ease-in-out infinite;
        }

        .floating-shapes::before {
            top: 10%;
            left: 10%;
            animation-delay: 0s;
        }

        .floating-shapes::after {
            bottom: 10%;
            right: 10%;
            animation-delay: 3s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        .exam-container {
            max-width: 900px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            padding: 40px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .exam-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 30px;
            border-radius: 16px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }

        .exam-header h2 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .exam-header p {
            font-size: 1.1rem;
            margin-bottom: 8px;
            opacity: 0.9;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .exam-header p strong {
            color: #ffd700;
        }

        .exam-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .info-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 12px;
            text-align: center;
            backdrop-filter: blur(5px);
        }

        .info-card .icon {
            font-size: 1.5rem;
            margin-bottom: 8px;
            display: block;
        }

        .question-block {
            margin-bottom: 30px;
            padding: 25px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            position: relative;
        }

        .question-block:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(0, 0, 0, 0.12);
        }

        .question-number {
            position: absolute;
            top: -10px;
            left: 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .question-text {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 20px;
            margin-top: 10px;
            color: #2d3748;
            line-height: 1.6;
            padding-left: 20px;
        }

        .question-text::before {
            content: "❓";
            margin-right: 8px;
        }

        .options-container {
            display: grid;
            gap: 12px;
            margin-top: 20px;
        }

        .option {
            margin: 0;
            position: relative;
        }

        .option label {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background: #f8fafc;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1rem;
            font-weight: 500;
            color: #2d3748;
        }

        .option label:hover {
            background: #e6f3ff;
            border-color: #667eea;
            transform: translateX(5px);
        }

        .option input[type="radio"] {
            margin-right: 15px;
            width: 20px;
            height: 20px;
            accent-color: #667eea;
        }

        .option label.selected {
            background: #667eea;
            color: white;
            border-color: #667eea;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .option-letter {
            background: #667eea;
            color: white;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.9rem;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .submit-container {
            text-align: center;
            margin-top: 40px;
            padding: 30px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
        }

        .submit-btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 18px 50px;
            font-size: 1.2rem;
            font-weight: 600;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            position: relative;
            overflow: hidden;
        }

        .submit-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .submit-btn:hover::before {
            left: 100%;
        }

        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
        }

        .submit-btn:active {
            transform: translateY(-1px);
        }

        .progress-bar {
            width: 100%;
            height: 6px;
            background: #e2e8f0;
            border-radius: 3px;
            margin-bottom: 30px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 3px;
            transition: width 0.3s ease;
        }

        .exam-warning {
            background: rgba(255, 193, 7, 0.1);
            border: 1px solid #ffc107;
            color: #856404;
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .exam-warning::before {
            content: "⚠️";
            font-size: 1.2rem;
        }

        @media (max-width: 768px) {
            .exam-container {
                padding: 20px;
                margin: 10px;
            }

            .exam-header {
                padding: 20px;
            }

            .exam-header h2 {
                font-size: 1.8rem;
            }

            .exam-info {
                grid-template-columns: 1fr;
            }

            .question-block {
                padding: 20px;
            }

            .question-text {
                font-size: 1rem;
            }

            .submit-btn {
                padding: 15px 30px;
                font-size: 1rem;
            }

            .option label {
                padding: 12px 15px;
                font-size: 0.9rem;
            }
        }

        /* Animation for question appearance */
        .question-block {
            animation: slideInUp 0.5s ease forwards;
            opacity: 0;
            transform: translateY(20px);
        }

        .question-block:nth-child(1) { animation-delay: 0.1s; }
        .question-block:nth-child(2) { animation-delay: 0.2s; }
        .question-block:nth-child(3) { animation-delay: 0.3s; }
        .question-block:nth-child(4) { animation-delay: 0.4s; }
        .question-block:nth-child(5) { animation-delay: 0.5s; }

        @keyframes slideInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="floating-shapes"></div>
    
    <div class="exam-container">
        <div class="exam-header">
            <h2>📚 ${exam.examTitle}</h2>
            <div class="exam-info">
                <div class="info-card">
                    <span class="icon">📖</span>
                    <strong>Subject:</strong> ${exam.subject}
                </div>
                <div class="info-card">
                    <span class="icon">🎯</span>
                    <strong>Total Marks:</strong> ${exam.totalMarks}
                </div>
                <div class="info-card">
                    <span class="icon">⏱️</span>
                    <strong>Duration:</strong> ${exam.duration} minutes
                </div>
            </div>
        </div>

        <div class="exam-warning">
            <strong>Important:</strong> Make sure to answer all questions before submitting. You cannot change your answers after submission.
        </div>

        <div class="progress-bar">
            <div class="progress-fill" style="width: 0%" id="progressBar"></div>
        </div>

        <form method="post" action="ExamCategoriesController" id="examForm">
            <input type="hidden" name="action" value="submit-exam"/>
            <input type="hidden" name="examId" value="${exam.examId}"/>
            
            <c:forEach var="q" items="${questions}" varStatus="loop">
                <div class="question-block">
                    <div class="question-number">Q${loop.index + 1}</div>
                    <div class="question-text">${q.questionText}</div>
                    
                    <div class="options-container">
                        <div class="option">
                            <label>
                                <div class="option-letter">A</div>
                                <input type="radio" name="answer_${q.questionId}" value="A" required/>
                                ${q.optionA}
                            </label>
                        </div>
                        <div class="option">
                            <label>
                                <div class="option-letter">B</div>
                                <input type="radio" name="answer_${q.questionId}" value="B"/>
                                ${q.optionB}
                            </label>
                        </div>
                        <div class="option">
                            <label>
                                <div class="option-letter">C</div>
                                <input type="radio" name="answer_${q.questionId}" value="C"/>
                                ${q.optionC}
                            </label>
                        </div>
                        <div class="option">
                            <label>
                                <div class="option-letter">D</div>
                                <input type="radio" name="answer_${q.questionId}" value="D"/>
                                ${q.optionD}
                            </label>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <div class="submit-container">
                <button class="submit-btn" type="submit">
                    🚀 Submit Exam
                </button>
            </div>
        </form>
    </div>

    <script>
        // Progress bar functionality
        const form = document.getElementById('examForm');
        const progressBar = document.getElementById('progressBar');
        const radioButtons = form.querySelectorAll('input[type="radio"]');
        const totalQuestions = ${questions.size()};
        
        function updateProgress() {
            const answeredQuestions = new Set();
            radioButtons.forEach(radio => {
                if (radio.checked) {
                    const questionId = radio.name.split('_')[1];
                    answeredQuestions.add(questionId);
                }
            });
            
            const progress = (answeredQuestions.size / totalQuestions) * 100;
            progressBar.style.width = progress + '%';
        }
        
        // Add event listeners to radio buttons
        radioButtons.forEach(radio => {
            radio.addEventListener('change', function() {
                updateProgress();
                
                // Update selected option styling
                const questionContainer = this.closest('.question-block');
                const labels = questionContainer.querySelectorAll('label');
                
                labels.forEach(label => {
                    label.classList.remove('selected');
                });
                
                this.parentElement.classList.add('selected');
            });
        });
        
        // Form submission confirmation
        form.addEventListener('submit', function(e) {
            const answeredQuestions = new Set();
            radioButtons.forEach(radio => {
                if (radio.checked) {
                    const questionId = radio.name.split('_')[1];
                    answeredQuestions.add(questionId);
                }
            });
            
            if (answeredQuestions.size < totalQuestions) {
                if (!confirm('You have not answered all questions. Are you sure you want to submit?')) {
                    e.preventDefault();
                }
            } else {
                if (!confirm('Are you sure you want to submit your exam? You cannot change your answers after submission.')) {
                    e.preventDefault();
                }
            }
        });
    </script>
</body>
</html>