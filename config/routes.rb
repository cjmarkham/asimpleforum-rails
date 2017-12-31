Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :user,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
    },
    controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      unlocks: 'users/unlocks',
      confirmations: 'users/confirmations',
    }

end
