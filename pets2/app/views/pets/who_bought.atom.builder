atom_feed do |feed|
	feed.title "Who bought #{@pet.name}"

	feed.updated @latest_foster.try(:updated_at)
	feed.entry(@pet.foster_parent) do |entry|
		entry.title "Foster number #{@pet.foster_parent.id}"
		entry.summary type: 'xhtml' do |xhtml|
			xhtml.p "Send to #{@pet.foster_parent.address}"
			xhtml.table do
				xhtml.tr do
					xhtml.th 'Name'
					xhtml.th 'Breed'
					xhtml.th 'Age'
				end
				xhtml.tr do
					xhtml.td @pet.name
					xhtml.td @pet.breed
					xhtml.td @pet.age
				end
			end
		end
		entry.author do |author|
			author.name @pet.foster_parent.name
			author.email @pet.foster_parent.email
		end
	end
end