import React from 'react';
import { useSelector } from 'react-redux';
import { RootState } from '../store/rootReducer';

interface HomeProps {
}

const Home: React.FC<HomeProps> = (props) => {
  const appVersion = useSelector((state: RootState) => state.app.version)

  return (
    <div className="p-3">
      <p>Home</p>
      <p>App version: {appVersion} </p>
      <p>can add components here for example / or add other pages</p>
    </div>
  );
};

export default Home;
