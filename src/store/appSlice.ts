import { createSlice, PayloadAction } from '@reduxjs/toolkit';

export interface AppState {
  version: string;
}

export const initialState: AppState = {
  version: process.env.REACT_APP_VERSION ? process.env.REACT_APP_VERSION : '',
};

const appSlice = createSlice({
  name: 'app',
  initialState: initialState,
  reducers: {
    reset: (state) => {
      state = { ...initialState };
      return state;
    },
    setVersion: (state, action: PayloadAction<string>) => {
      state.version = action.payload;
    },
  },
});

export const appActions = appSlice.actions;

export default appSlice.reducer;
