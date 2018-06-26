module HashTagHelper

	def reRa_count
		@reRa = HashTag.all.map{ |c| [c.name, c.rating_ids.count + c.reply_ids.count]}.to_h
		@reRa = @reRa.sort_by{ |key, value| value }.reverse.to_h
		return @reRa
	end
		

	def mappedTags
		@tags = HashTag.all.map{ |c| [c.name, c.reply_ids]}.to_h
		@tags.delete_if{|key, value| value.count == 0}
		return @tags
	end

	def otherTags
		@other_tags = HashTag.all.map{ |c| [c.name, c.rating_ids]}.to_h
		@other_tags.delete_if{|key, value| value.count == 0}
		return @other_tags
	end

end
