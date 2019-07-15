require './settings'
require 'pg'

class RedshiftClient
  def initialize
    options = ''
    tty = ''
    settings = Settings.load
    settings = settings['redshift']
    @conn = PG::Connection.new(settings['host'], settings['port'], options, tty, settings['dbname'], settings['dbuser'], settings['dbpassword'])
  end

  def create_record(from, to, body, created_date)
    @conn.query("INSERT INTO messages values('#{from}', '#{to}', '#{body}', '#{created_date}')")
  end
end