import React, { Component } from "react";
import logo from "./logo.svg";
import "./App.css";

class App extends Component {
    constructor(props) {
        super(props);
        this.state = { 
            apiResponse: "waiting for api",
            dbResponse: "waiting for db"
        };
    }
    callAPI() {
        fetch("https://workshop-api-dot-cwb-ci-bootcamp.wl.r.appspot.com/testAPI")
            .then(res => res.text())
            .then(res => this.setState({ apiResponse: res }))
            .catch(err => err);
    }
    callDB() {
        fetch("https://workshop-api-dot-cwb-ci-bootcamp.wl.r.appspot.com/testDB")
            .then(res => res.text())
            .then(res => this.setState({ dbResponse: res }))
            .catch(err => err);
    }
    componentDidMount() {
        this.callAPI();
        this.callDB();
    }

    render() {
        return (
            <div className="App">
                <header className="App-header">
                    <img src={logo} className="App-logo" alt="logo" />
                    <h1 className="App-title">a distributed web service on Google app engine</h1>
                </header>
                <p className="App-intro">{this.state.apiResponse}</p>
                <p className="App-intro">{this.state.dbResponse}</p>
            </div>
        );
    }
}

export default App;
