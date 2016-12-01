function login() {
    var nick = document.getElementById('username').value;
    var pass = document.getElementById('userpasswd').value;
    var sessionRequest = new XMLHttpRequest();
    sessionRequest.open('GET', 'api/v1/get_session.php', true);
    sessionRequest.setRequestHeader('nick', nick);
    sessionRequest.setRequestHeader('pass', pass);
    sessionRequest.send();
    sessionRequest.onreadystatechange = function() {
        if (sessionRequest.readyState == 4 && sessionRequest.status == 200) {
            var json = JSON.parse(sessionRequest.responseText);
            if (json.status != 0) {
                alert('ERROR #' + errorNumber(json.status) + ': ' + json.message);
            } else {
                sessionStorage['employee_session'] = JSON.stringify(json.session);
                location = 'index.html';
            }
        }
    }
}

function errorNumber(n) {
    return Math.floor(n / 7 * 1000);
}
