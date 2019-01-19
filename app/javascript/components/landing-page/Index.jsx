import React, { Component } from 'react';
import { Link, BrowserRouter, Route, Switch } from 'react-router-dom';
import './css/landing-page.css'
import MainPic from './img/main.png'
import Linkedin from '../../../assets/images/Linkedin.png'

class Index extends Component {
    state = {}
    render() {
        return (
            <React.Fragment>
                <BrowserRouter>
                    <React.Fragment>
                        <Switch>
                            <React.Fragment>

                                <div className="main-parent-div">
                                    <Link to="/"><img className="main-child-logo" src={Linkedin} alt="Not uploaded" /></Link>
                                    <div className="main-child-nav"></div>
                                    <div className="main-child-content">
                                        <h1>LinkedIn Campus Chapter</h1>
                                        <p>A website that bridges the gap between Campus to Corporate. Join this to stay connected with your campus, share events, jobs and get mentorship !</p>
                                    </div>
                                    <img className="main-child-pic" src={MainPic} alt="Not uploaded" />
                                    <div className="main-child-div"><a href="/login"><button className="main-child-btn">Login</button></a></div>
                                    <div className="main-child1-div"><a href="/signup"><button className="main-child-btn">Register</button></a></div>
                                </div>
                            </React.Fragment>
                        </Switch>
                    </React.Fragment>
                </BrowserRouter>

            </React.Fragment>
        );
    }
}

export default Index;