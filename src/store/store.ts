import { configureStore, getDefaultMiddleware } from '@reduxjs/toolkit'
import { appActions } from './appSlice';
import rootReducer from './rootReducer';

const middleWare = [...getDefaultMiddleware()];

const store = configureStore({
  reducer: rootReducer,
  middleware: middleWare,
  // preloadedState: loadState(),
});

export const resetStore = () => {
  store.dispatch(appActions.reset());
}

export type AppDispatch = typeof store.dispatch;

export default store;


if (process.env.NODE_ENV === 'development' && module.hot) {
  module.hot.accept('./rootReducer', () => {
    const newRootReducer = require('./rootReducer').default
    store.replaceReducer(newRootReducer)
  })
}
