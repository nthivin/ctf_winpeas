document.addEventListener('DOMContentLoaded', function () {
    const loginForm = document.getElementById('login-form');
    const responseDiv = document.getElementById('response');

    loginForm.addEventListener('submit', function (e) {
        e.preventDefault();

        const formData = new FormData(loginForm);

        var user = formData.get("username");
        var pwd = formData.get("password");

        if (user === "admin" && pwd == "admin") {
            document.getElementById("response").innerHTML = 'Are you serious ?';
        } else {
            document.getElementById("response").innerHTML = 'Wrong username or password';
        }
        
    });
});
