import React from 'react';

interface HomeProps {
}

const Home: React.FC<HomeProps> = (props) => {
  return (
    <div className="p-3">
      <p>Home</p>
      <p>can add components here for example / or add other pages</p>
    </div>
  );
};

export default Home;
