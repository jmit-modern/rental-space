require "sidekiq"
require "sidekiq/web"

Rails.application.routes.draw do
  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
  end
  mount Sidekiq::Web, at: "/sidekiq"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :front do
        resources :users

        resources :experts
        post "/experts/:id/add_skill", to: "experts#add_skill"

        get "/expert_reservations", to: "expert_reservations#index"
        get "/expert_reservations/:id", to: "expert_reservations#show"
        post "/expert_reservations/checkout", to: "expert_reservations#checkout"
        post "/expert_reservations/charge", to: "expert_reservations#charge"
        post "/expert_reservations/:id/approve", to: "expert_reservations#approve"
        get "/expert_reservation_orders", to: "expert_reservations#orders"
        get "/expert_reservation_disabled_dates", to: "expert_reservations#disabled_dates"

        resources :events
        post "/events/:id/add_image", to: "events#add_image"
        post "/events/:id/purchase", to: "events#purchase"
        delete "/events/:id/remove_image/:image_id", to: "events#remove_image"

        get "/event_reservations", to: "event_reservations#index"
        get "/event_reservations/:id", to: "event_reservations#show"
        post "/event_reservations/check_user_reserved", to: "event_reservations#check_user_reserved"
        post "/event_reservations/charge", to: "event_reservations#charge"
        get "/event_reservation_orders", to: "event_reservations#orders"

        resources :spaces
        post "/spaces/:id/add_image", to: "spaces#add_image"
        delete "/spaces/:id/remove_image/:image_id", to: "spaces#remove_image"
        get "/spaces/:id/plan", to: "spaces#get_plan"
        post "/spaces/:id/plan", to: "spaces#add_plan"
        put "/spaces/:id/plan/:plan_id", to: "spaces#update_plan"
        delete "/spaces/:id/plan/:plan_id", to: "spaces#remove_plan"
        put "/spaces/:id/facilities", to: "spaces#update_facilities"
        get "/space_types", to: "spaces#space_types"
        get "/spaces/:id/related_spaces", to: "spaces#related"

        post "/auth/login", to: "auth#login"
        get "/auth/me", to: "auth#show"
        post "/auth/register", to: "users#create"
        post "/auth/logout", to: "auth#logout"
        post "/auth/reset_password", to: "auth#reset_password"
        post "/auth/update_password", to: "auth#update_password"

        get "/users", to: "users#index"
        get "/users/:id", to: "users#show"
        put "/users/:id/update", to: "users#update"
        put "/users/:id/update_password", to: "users#update_password"
        put "/users/:id/update_email", to: "users#update_email"
        put "/users/:id/confirm_user", to: "users#confirm_user"
        get "/user_types", to: "users#user_types"

        get "/top/new_spaces", to: "top_content#new_spaces"
        get "/top/pickup_spaces", to: "top_content#pickup_spaces"
        get "/prefectures", to: "prefectures#index"
        get "/categories", to: "categories#index"
        get "/languages", to: "languages#index"

        post "/uploads/create", to: "uploads#create"
        post "/uploads/delete", to: "uploads#delete"

        get "/skills", to: "skills#index"
        get "/skills_by_user", to: "skills#skills_by_user"

        get "/reservations", to: "reservations#index"
        get "/reservations/:id", to: "reservations#show"
        post "/reservations/checkout", to: "reservations#checkout"
        post "/reservations/charge", to: "reservations#charge"
        post "/reservations/:id/approve", to: "reservations#approve"
        get "/reservation_orders", to: "reservations#orders"
        get "/reservation_disabled_dates", to: "reservations#disabled_dates"

        get "/facility_categories", to: "facility_categories#index"

        post "/contact", to: "contact#send_form"
      end

      namespace :admin do
        post "/auth/login", to: "auth#login"
        post "/auth/logout", to: "auth#logout"
        get "/auth/me", to: "auth#show"
        post "/auth/reset_password", to: "auth#reset_password"
        post "/auth/update_password", to: "auth#update_password"

        get "/users", to: "users#index"
        get "/users/:id", to: "users#show"
        put "/users/:id", to: "users#update"

        get "/spaces", to: "spaces#index"
        get "/spaces/:id", to: "spaces#show"
        put "/spaces/:id", to: "spaces#update"
        get "/space_types", to: "spaces#space_types"
        get "/space_statuses", to: "spaces#statuses"

        get "/events", to: "events#index"
        get "/events/:id", to: "events#show"
        put "/events/:id", to: "events#update"
        get "/event_statuses", to: "events#statuses"

        get "/experts", to: "experts#index"
        get "/experts/:id", to: "experts#show"
        put "/experts/:id", to: "experts#update"

        post "/uploads/create", to: "uploads#create"
        post "/uploads/delete", to: "uploads#delete"
      end
    end
  end
end
