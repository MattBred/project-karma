# User is praising/shaming a deed.
post '/deeds/:id/praise' do
  create_praise.to_s
end

post '/deeds/:id/shame' do
  create_shame.to_s
end

post '/deeds' do 
  deed = Deed.new(
    user_id: current_user.id,
    summary: params[:summary]
    )
  if deed.save
    session[:pagination_spot] += 1
    erb :'../views/deeds/_show', layout: false, locals: {all_details: true, deed: deed}
  else
    redirect '/'
  end
end

get '/deeds/next' do 
  puts session[:pagination_spot]
  puts "list.last.id is: #{Deed.last.id}"
  unless session[:pagination_spot] == Deed.last.id
    erb :'../views/deeds/_pagination', layout: false, locals: {all_details: true, list: Deed.all.limit(MAX_SHOW).offset(session[:pagination_spot]).order(id: :desc)}
  end
end
