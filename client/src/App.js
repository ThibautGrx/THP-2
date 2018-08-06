import React, { Component } from 'react';
import './App.css';

import Navbar from './components/navbar'
import Auth from './auth/auth'
import Index from './pages/index'
import Lessons from './pages/lessons'
import Footer from './components/footer'
import { Router, Route } from 'react-router-dom'
import createBrowserHistory from 'history/createBrowserHistory'


const history = createBrowserHistory({})

class App extends Component {
  render() {
    return (
        <Router history={history}>
          <div>
            <Navbar />
              <Route exact path="/" component={Index}/>
              <Route exact path="/lessons" component={Lessons}/>
              <Route path="/auth/:action" component={Auth}/>
              <Route path="/lessons" component={Lessons}/>
            <Footer />
          </div>
        </Router>
    );
  }
}

export default App;
