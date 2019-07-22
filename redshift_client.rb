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

  def create_record(body, created_date)
    @conn.query("INSERT INTO messages(body, created_date) values('#{body}', '#{created_date}')")
  end
end