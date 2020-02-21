module Slugifiable
    module InstanceMethods
      def slug
        name = self.name.downcase.split(" ")
        name.join("-")
      end
    end
    module ClassMethods
      def find_by_slug(slug)
        slug = slug.split("-").map(&:capitalize)
        name = slug.join(" ")
        self.where("name like ?", "#{name}").first
      end
    end
end