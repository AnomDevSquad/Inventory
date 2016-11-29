class Employee {
    constructor(employeJsonObj) {
        this._id = employeJsonObj.id;
        this._nickname = employeJsonObj.nickname;
        this._name = employeJsonObj.name;
        this._lastName = employeJsonObj.lastName;
        this._type = employeJsonObj.type;
    }

    get id() {
        return this._id;
    }
    get nickname() {
        return this._nickname;
    }
    get name() {
        return this._name;
    }
    get lastName() {
        return this._lastName;
    }
    get type() {
        return this._type;
    }
}

class Session {
    constructor(jsonSessionString) {
        var jsonSessionObj = JSON.parse(jsonSessionString);
        this._employee = new Employee(jsonSessionObj.employee);
        this._date = jsonSessionObj.date;
        this._token = jsonSessionObj.token;
    }

    get employee() {
        return this._employee;
    }
    get date() {
        return this._date;
    }
    get token() {
        return this._token;
    }
}

initSession();

function initSession() {
    if (location.toString().indexOf('login.html') < 0) {
        if (typeof sessionStorage["employee_session"] === 'undefined')
            location = 'login.html';
        else {
            var localSession = new Session(sessionStorage["employee_session"]);
            session(localSession);
        }
    }
}

function session(localSession) {

}

function closeSession(){
  location = 'login.html';
}
