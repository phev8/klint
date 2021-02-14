import React from 'react';
import RootSwitch from './router/RootSwitch';
import { BrowserRouter as Router } from 'react-router-dom';

const App: React.FC = () => {
  return (
    <Router basename={process.env.NODE_ENV === 'production' ? process.env.PUBLIC_URL : undefined}>
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
