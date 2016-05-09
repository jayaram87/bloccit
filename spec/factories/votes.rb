FactoryGirl.define do
    factory :vote do
        value 'rand(-1,1)'
        post
        user
    end
end