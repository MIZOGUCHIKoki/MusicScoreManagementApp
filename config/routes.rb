# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'

  get '/help', to: 'static_pages#help'
  get '/release_note', to: 'static_pages#release_note'

  resources :users
  resources :scores
  # GET	    /users	        index	  users_path	          すべてのユーザーを一覧するページ
  # GET     /users/1	      show	  user_path(user)	      特定のユーザーを表示するページ
  # GET	    /users/new	    new	    new_user_path	        ユーザーを新規作成するページ（ユーザー登録）
  # POST    /users	        create	users_path	          ユーザーを作成するアクション
  # GET	    /users/1/edit	  edit	  edit_user_path(user)	id=1のユーザーを編集するページ
  # PATCH	  /users/1	      update	user_path(user)	      ユーザーを更新するアクション
  # DELETE	/users/1	      destroy	user_path(user)	      ユーザーを削除するアクション

  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
