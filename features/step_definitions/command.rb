Then(/^the SSH command "(.+?)" should return some output containing "(.+?)"/) do |cmd, output|
  run("vagrant ssh -c \"#{cmd}\"")
  expect(last_command_started).to have_output(/#{output}/)
end

Then(/^the WinRM command "(.+?)" should return some output containing "(.+?)"/) do |cmd, output|
  run("vagrant winrm -c \"#{cmd}\"")
  expect(last_command_started).to have_output(/#{output}/)
end
