library(httr)
library(jsonlite)
library(ggplot2)
library(cowplot)
library(purrr)

#intent is to pass the getUserData response to this function directly
#returns stats for the 10 most recent matches
#TODO res_ls$LifeTimeStats
#also much more finegrained stats in res_ls$stats if interested in rabbithole

parseUserData<-function(response){
  if(http_type(response) != "application/json"){
    warning("response is not a json, can't parse")}
  res_ls<-jsonlite::fromJSON(content(response, "text"), simplifyVector = FALSE)
  recent<-res_ls$recentMatches
  kills<-flatten_int(map(recent,function(x) x$kills))
  score<-flatten_dbl(map(recent,function(x) x$score))
  playtype<-flatten_chr(map(recent,function(x) x$playlist))
  trnchange<-flatten_dbl(map(recent,function(x) x$trnRatingChange))
  trnrating<-flatten_dbl(map(recent,function(x) x$trnRating))
  gid<-flatten_int(map(recent,function(x) x$id))
  df<-tibble::tibble(game_id=gid,kills=kills,score=score,ptype=playtype,trnchange=trnchange,trnrating=trnrating,matches=1:10)
  return(df)
}

#simple boring non-interactive or anything plot
plot_kills<-function(df){
  p1<-ggplot(aes(kills),data=df)+geom_histogram()
  p2<-ggplot(aes(score),data=df)+geom_histogram()
  p3<-plot_grid(p1,p2)
  print(p3) #this is boring as heck
}