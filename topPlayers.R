library(rvest)
#initial scraping function
#there is definitely a captcha on the leaderboards, but I don't know what trips it
getTopUsers<-function(platform){
  if(!(platform %in% c("xbox", "pc", "psn")){
    warning("Only xbox, pc, and psn platforms available currently")
  }
url<-"https://fortnitetracker.com/leaderboards/pc/Top1?mode=all"
url1<-"https://fortnitetracker.com/leaderboards/"
url2<-"/Top1?mode=all"
jurl<-paste(url1,platform,url2,sep="")
webp<-read_html(jurl)
rank_data_html <- html_nodes(webp,'.trn-lb-entry__name')
rank_names<-html_text(rank_data_html)
return(rank_names)
}