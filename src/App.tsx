import React from 'react';
import RootSwitch from './router/RootSwitch';
import { HashRouter as Router } from 'react-router-dom';

const App: React.FC = () => {
  return (
    <Router basename="/">
      <div className="container-fluid">
        <div className="row">
          <div className="bg-primary p-2">
            <h1>KLINT</h1>
          </div>

        </div>
      </div>
      <RootSwitch />
    </Router>
  );
};

export default App;
