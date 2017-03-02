module ApplicationHelper

  def group_category_select
    Category.all.map{|category| [category.name, category.sub_category_select]}
  end

  def rate_select
    (Settings.min_rate..Settings.max_rate).map {|i| [pluralize(i, "star"), i]}
  end

end
