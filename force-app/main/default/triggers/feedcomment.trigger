trigger feedcomment on FeedComment (before insert) {
  
    ApplicationFeedCommentHandler.handleBeforeInsert(Trigger.new);



}