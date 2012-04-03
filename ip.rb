if File::exists?("/sbin/ip")
  Facter.add('gateway') do
    setcode do
      `/sbin/ip route show`.match(/^default.*/)[0].match(/(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/)[0]
    end
  end
end