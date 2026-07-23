public class ApplicationFeedCommentHandler {
   public static void handleBeforeInsert(List<FeedComment> newComments) {
        // Collect parent IDs of comments related to Case records
        Set<Id> parentIds = new Set<Id>();
        for (FeedComment comment : newComments) {
            if (comment.ParentId != null && comment.CommentType == 'ContentComment') {
                parentIds.add(comment.ParentId);
            }
        }

        if (!parentIds.isEmpty()) {
            // Query related Case records
            Map<Id, Case> relatedCasesMap = new Map<Id, Case>(
                [SELECT Id FROM Case WHERE Id IN :parentIds]
            );

            // Iterate over new comments and apply restriction
            for (FeedComment comment : newComments) {
                if (relatedCasesMap.containsKey(comment.ParentId)) {
                    // Add an error to prevent saving the comment with an attachment
                    comment.addError('You are not allowed to add an attachment into a comment.');
                }
            }
        }
    }
}