class UUID
	def self.calc(instance)
		raise "Instance does not have an ID yet #{instance}" if not instance.id
		(Digest::SHA1.hexdigest(instance.class.name + instance.id.to_s + rand(1000).to_s).to_i(16) % (10**12)).to_s(36)
	end
end