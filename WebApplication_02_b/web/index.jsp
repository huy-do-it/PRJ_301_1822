<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Create Account</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f8fb;
    }
    .card {
      max-width: 400px;
      margin: auto;
      margin-top: 50px;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
    }
    .error {
      font-size: 0.9rem;
    }
  </style>
</head>
<body>

  <div class="card p-4">
    <h3 class="text-center mb-4">Create Your Account</h3>
    <form>
      <!-- Full Name -->
      <div class="mb-3">
        <label for="fullname" class="form-label">Full Name</label>
        <input type="text" class="form-control is-invalid" id="fullname" placeholder="John Doe">
        <div class="invalid-feedback">Tên không h?p l?</div>
      </div>

      <!-- Email -->
      <div class="mb-3">
        <label for="email" class="form-label">Email Address</label>
        <input type="email" class="form-control is-invalid" id="email" placeholder="example@email.com">
        <div class="invalid-feedback">Email không h?p l?</div>
      </div>

      <!-- Phone -->
      <div class="mb-3">
        <label for="phone" class="form-label">Phone Number</label>
        <input type="text" class="form-control is-invalid" id="phone" placeholder="0123 456 789">
        <div class="invalid-feedback">S? ?T ph?i 10 s?, b?t ??u 0</div>
      </div>

      <!-- Password -->
      <div class="mb-3">
        <label for="password" class="form-label">Password</label>
        <input type="password" class="form-control is-invalid" id="password">
        <div class="invalid-feedback">M?t kh?u ít nh?t 6 ký t?</div>
      </div>

      <!-- Confirm Password -->
      <div class="mb-3">
        <label for="confirmPassword" class="form-label">Confirm Password</label>
        <input type="password" class="form-control is-invalid" id="confirmPassword">
        <div class="invalid-feedback">Xác nh?n m?t kh?u sai</div>
      </div>

      <!-- Checkbox -->
      <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="termsCheck">
        <label class="form-check-label" for="termsCheck">
          I agree to the <a href="#">Terms & Conditions</a>
        </label>
      </div>

      <!-- Button -->
      <div class="d-grid">
        <button type="submit" class="btn btn-primary">Sign Up</button>
      </div>

      <!-- Login Link -->
      <div class="text-center mt-3">
        Already have an account? <a href="#">Login here</a>
      </div>
    </form>
  </div>

</body>
</html>
