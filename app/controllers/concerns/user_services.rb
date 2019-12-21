class UserServices
  class << self

    def check_last_locked_times(user)
      if user.last_locked_search_time.nil?
        0
      else
        diff = Time.now - user.last_locked_search_time
        (diff / 60 / 60).to_i
      end
    end

    def check_locked(user)
      check_last_locked_times(user) >= 12 ?  user.update(search_count: 0, last_locked_search_time: nil) : user.update(search_count: user.search_count + 1, last_locked_search_time: Time.now)
    end
  end
end