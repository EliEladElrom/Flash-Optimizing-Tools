/**
* ...
* @author Martin Legris
* @version 0.1
*/

package ca.newcommerce.youtube
{
	import ca.newcommerce.youtube.data.*;
	import ca.newcommerce.youtube.events.CommentFeedEvent;
	import ca.newcommerce.youtube.events.ContactFeedEvent;
	import ca.newcommerce.youtube.feeds.*;
	import ca.newcommerce.youtube.iterators.*;
	
	public class DataTracer
	{		
		public static function traceVideos(videoFeed:VideoFeed):void
		{
			traceAbstractFeed("videos", videoFeed);
			
			var video:VideoData;
			while (video = videoFeed.next())
			{
				trace("");
				traceVideo(video);
			}
		}
		
		public static function traceAbstractFeed(preset:String, afeed:AbstractFeed):void
		{
			trace(preset+".logo:" + afeed.logo)
			trace(preset+".id:" + afeed.id);
			trace(preset+".title:" + afeed.title);
			trace(preset+".updated:" + afeed.updated);
			trace(preset+".totalResults:" + afeed.totalResults);
			trace(preset+".startIndex:" + afeed.startIndex);
			trace(preset+".itemsPerPage:" + afeed.itemsPerPage);

			traceAuthors(afeed.authors);
			traceLinks(afeed.links);
			traceCategories(afeed.categories);
			
			traceGenerator(afeed.generator);

		}
		
		public static function tracePlaylists(playlists:PlaylistFeed):void
		{
			traceAbstractFeed("playlists", playlists);
			
			var playlist:PlaylistData;
			while (playlist = playlists.next())
			{
				trace("");
				tracePlaylist(playlist);
			} 
		}
		
		public static function traceContacts(contacts:ContactFeed):void
		{
			traceAbstractFeed("contacts", contacts);
			
			var contact:ContactData;
			
			while (contact = contacts.next())
			{
				trace("");
				traceContact(contact);
			}
		}		
		
		protected static function traceContact(contact:ContactData):void
		{
			trace("contact.id:" + contact.id);
			trace("contact.username:" + contact.username);
			trace("contact.status:" + contact.status);
			trace("contact.title:" + contact.title);			
			
			traceCategories(contact.categories);
			traceLinks(contact.links);			
			
			trace("");
			trace("contact.published:" + contact.published);
			trace("contact.updated:" + contact.updated);
		}
		
		public static function traceComments(comments:CommentFeed):void
		{
			traceAbstractFeed("comments", comments);
			
			var comment:CommentData;
			while (comment = comments.next())
			{
				trace("");
				traceComment(comment);
			}
		}
		
		protected static function traceComment(comment:CommentData):void
		{
			trace("comment.id:" + comment.id);
			trace("comment.title:" + comment.title);
			trace("comment.content:" + comment.content);
			traceAuthors(comment.authors);
			traceCategories(comment.categories);
			traceLinks(comment.links);
			
			trace("");
			trace("comment.published:" + comment.published);
			trace("comment.updated:" + comment.updated);
		}
		
		public static function traceSubscriptions(subFeed:SubscriptionFeed):void
		{
			traceAuthors(subFeed.authors);
			traceCategories(subFeed.categories);
			traceLinks(subFeed.links);
			
			trace("subFeed.count:" + subFeed.count);
			trace("subFeed.generator:" + subFeed.generator);
			trace("subFeed.id:" + subFeed.id);
			trace("subFeed.itemsPerPage:" + subFeed.itemsPerPage);
			trace("subFeed.logo:" + subFeed.logo );
			trace("subFeed.startIndex:" + subFeed.startIndex);
			trace("subFeed.title:" + subFeed.title);
			trace("subFeed.totalResults:" + subFeed.totalResults);
			trace("subFeed.updated:" + subFeed.updated);
			
			var subscription:SubscriptionData;
			
			while (subscription = subFeed.next())
			{
				trace("");
				traceSubscription(subscription);
			}
		}
		
		protected static function tracePlaylist(playlist:PlaylistData):void
		{
			trace("playlist.title:" + playlist.title);
			trace("playlist.id:" + playlist.id);
			trace("playlist.published:" + playlist.published);
			trace("playlist.updated:" + playlist.updated);
			trace("playlist.actualId:" + playlist.actualId);
			trace("playlist.authors:" + playlist.authors);
			traceCategories(playlist.categories);
			trace("playlist.content:" + playlist.content);
			trace("playlist.description:" + playlist.description);
			traceFeedLink(playlist.feedLink);
			traceLinks(playlist.links);
		}
		
		protected static function traceVideo(video:VideoData):void
		{
			trace("video.title:" + video.title);
			trace("video.id:" + video.id);
			trace("video.actualId:" + video.actualId);
			trace("video.viewCount:" + video.viewCount);
			trace("video.commentCount:" + video.commentCount);
			trace("video.commentFeedUri:" + video.commentFeedUri);
			trace("video.content: " + video.content);
			trace("video.published:" + video.published);			
			
			var rating:RatingData = video.rating;
			trace("rating.average:" + rating.average);
			trace("rating.max:" + rating.max);
			trace("rating.min:" + rating.min);
			trace("rating.numRaters:" + rating.numRaters);			
			
			traceAuthors(video.authors);
			traceLinks(video.links);
			traceCategories(video.categories);
			traceMediaGroup(video.media);
			
			trace("");
			trace("video.swfUrl:" + video.swfUrl);
			trace("video.keywords:" + video.keywords);
			trace("video.categorywords:" + video.categorywords);
			trace("video.mobileUrl:" + video.mobileUrl);
			trace("video.duration:" + video.duration);
		}
		
		protected static function traceThumbnails(thumbnails:ThumbnailIterator):void
		{
			var thumbnail:ThumbnailData;
			
			while (thumbnail = thumbnails.next())
			{
				trace("");
				trace("thumbnail.height:" + thumbnail.height);
				trace("thumbnail.width:" + thumbnail.width);
				trace("thumbnail.url:" + thumbnail.url);
				trace("thumbnail.time:" + thumbnail.time);
			}		
		}
		
		protected static function traceGenerator(generator:GeneratorData):void
		{
			trace("");
			trace("generator.text:" + generator.text);
			trace("generator.version:" + generator.version);
			trace("generator.uri:" + generator.uri);
		}
		
		protected static function traceMediaGroup(mediaGroup:MediaGroupData):void
		{
			trace("");
			trace("mediaGroup.description:" + mediaGroup.description);
			trace("mediaGroup.duration:" + mediaGroup.duration);
			trace("mediaGroup.keywords:" + mediaGroup.keywords);
			trace("mediaGroup.mediaPlayerUri:" + mediaGroup.mediaPlayerUri);
			trace("mediaGroup.title:" + mediaGroup.title);
			
			
			traceThumbnails(mediaGroup.thumbnails);
			traceCategories(mediaGroup.categories);
			traceMediaContent(mediaGroup.contents);
		}
		
		protected static function traceMediaContent(contentFeed:MediaContentIterator):void
		{
			var content:MediaContentData;
			
			while (content = contentFeed.next())
			{
				trace("");
				trace("content.duration:" + content.duration);
				trace("content.expression:" + content.expression);
				trace("content.format:" + content.format);
				trace("content.isDefault:" + content.isDefault);
				trace("content.type:" +	content.type);
				trace("content.url:" + content.url);
			}
		}		
		
		protected static function traceSubscription(sub:SubscriptionData):void
		{
			trace("sub.id:" + sub.id);
			trace("sub.title:" + sub.title);
			trace("sub.username:" + sub.username);
			trace("sub.published:" + sub.published);			
			trace("sub.updated:" + sub.updated);
			
			traceFeedLink(sub.feedLink);			
			traceAuthors(sub.authors);
			traceCategories(sub.categories);			
			traceLinks(sub.links);
		}
		
		protected static function traceAuthors(authors:AuthorIterator):void
		{
			var author:AuthorData;
			
			while (author = authors.next())
			{
				trace("author.name:" + author.name);
				trace("author.uri:" + author.uri);
				trace("author.username:" + author.username);
			}
		}
		
		protected static function traceCategories(categories:CategoryIterator):void
		{
			var category:CategoryData;
			trace("");
			while (category = categories.next())
			{
				trace("");
				trace("category.label:" + category.label);
				trace("category.scheme:" + category.scheme);
				trace("category.term:" + category.term);
				trace("category.text:" + category.text);
			}
		}
		
		protected static function traceStatistics(stats:StatisticsData):void
		{
			trace("");
			trace("stats.lastWebAccess:" + stats.lastWebAccess);
			trace("stats.videoWatchCount:" + stats.videoWatchCount);
			trace("stats.viewCount:" + stats.viewCount );
		}
		
		protected static function traceLinks(links:LinkIterator):void
		{
			var link:LinkData;		
			
			while (link = links.next())
			{
				trace("");
				trace("link.href:" + link.href);
				trace("link.rel:" + link.rel);
				trace("link.type:" + link.type);				
			}
		}
		
		protected static function traceFeedLinks(feedLinks:FeedLinkIterator):void
		{
			var feedLink:FeedLinkData;
			
			while(feedLink = feedLinks.next())
			{
				traceFeedLink(feedLink);
			}
		}
		
		protected static function traceFeedLink(feedLink:FeedLinkData):void
		{
			trace("");
			trace("feedLink.countHint:" + feedLink.countHint);
			trace("feedLink.href:" + feedLink.href);
			trace("feedLink.rel:" + feedLink.rel);	
		}
		
		public static function traceProfile(user:ProfileData):void
		{
			trace("");
			trace("user.username:" + user.username);
			trace("user.location:" + user.location);
			
			trace("user.firstname:" + user.firstname);
			trace("user.lastname:" + user.lastname);			
			
			traceFeedLinks(user.feedLinks);
			trace("");
			traceLinks(user.links);		
			trace("");
			
			trace("user.age:" + user.age);
			
			traceStatistics(user.statistics);			
			trace("");
		
			trace("user.id:" + user.id);
			
			traceAuthors(user.author);
			trace("");			
			traceCategories(user.categories);
			trace("");			
			
			trace("user.title:" + user.title);
			trace("user.updated:" + user.updated);
			trace("user.gender:" + user.gender);
			trace("user.published:" + user.published);
			
			trace("user.books:" + user.books)
			trace("user.company:" + user.company);
			trace("user.hobbies:" + user.hobbies);
			trace("user.hometown:" + user.hometown);
			
			trace("user.movies:" + user.movies);
			trace("user.music:" + user.music);
			trace("user.occupation:" + user.occupation);
			trace("user.relationship:" + user.relationship);
			trace("user.school:" + user.school);			
		
			trace("user.thumbnail:" + user.thumbnail);
		}
	}
}