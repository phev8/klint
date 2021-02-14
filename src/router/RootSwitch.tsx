import React from 'react';
import { Redirect, Route, Switch } from 'react-router-dom';
import Home from '../pages/Home';
import { AppRoutes } from './appRoutes';

interface RootSwitchProps {
}

const RootSwitch: React.FC<RootSwitchProps> = (props) => {
  return (
    <Switch>
      <Route path={AppRoutes.Home} component={Home} />
      <Redirect to={AppRoutes.Home} />
    </Switch>
  );
};

export default RootSwitch;
