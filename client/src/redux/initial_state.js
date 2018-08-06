const initialState = {
  reduxTokenAuth: {
    currentUser: {
      isLoading: false,
      isSignedIn: false,
      attributes: {
        username: null,
        email: null,
      },
    },
  },
}

export default initialState
