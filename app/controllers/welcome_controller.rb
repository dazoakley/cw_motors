class WelcomeController < ApplicationController
  def index
  end

  def backup
    filename       = "cw_motors-#{Date.today.to_s}.sql"
    db_backup_path = "#{Rails.root}"
    backup_conf    = "#{Rails.root}"
    script_path    = "#{Rails.root}"

    if RUBY_PLATFORM.downcase.include?("mswin")
      db_backup_path << "\\backup\\#{filename}"
      backup_conf << "\\config\\backup.yml"
      script_path << "\\backup\\script.txt"
    else
      db_backup_path << "/backup/#{filename}"
      backup_conf << "/config/backup.yml"
      script_path << "/backup/script.txt"
    end

    # Dump the database...
    dump_database(db_backup_path)

    ##
    ## Upload to server...
    ##

    backup_conf = YAML.load_file(backup_conf)

    if RUBY_PLATFORM.downcase.include?("mswin")
      winscp_command = [
        'winscp.exe',
        '/console',
        '/command',
        '"option batch abort"',
        "\"open sftp://#{backup_conf['username']}:#{backup_conf['password']}@#{backup_conf['host']}:/srv/cw_motors_backups/\"",
        '"option transfer binary"',
        "\"put #{db_backup_path}\"",
        '"close"',
        '"exit"'
      ]

      winscp_command = winscp_command.join(' ')
      `#{winscp_command}`
    else
      scp_command = [
        'scp',
        db_backup_path,
        "#{backup_conf['username']}@#{backup_conf['host']}:/srv/cw_motors_backups/#{filename}"
      ]

      scp_command = scp_command.join(' ')
      `#{scp_command}`
    end

    redirect_to root_path
  end

  private

  def dump_database(backup_file)
    Rails.logger.info("\n\n")
    Rails.logger.info("Running database dump into #{backup_file} ...")

    pg_dump_cmd = []

    if RUBY_PLATFORM.downcase.include?("mswin")
      pg_dump_cmd << 'pg_dump'
    else
      pg_dump_cmd << 'pg_dump'
    end

    db_conf = CwMotors::Application.config.database_configuration[Rails.env]

    pg_dump_cmd << "--host #{db_conf['host'] ? db_conf['host'] : 'localhost'}"
    pg_dump_cmd << "--port #{db_conf['port'] ? db_conf['port'] : '5432'}"
    pg_dump_cmd << "--username #{db_conf['username']}"
    pg_dump_cmd << '--no-password'
    pg_dump_cmd << '--format plain'
    pg_dump_cmd << '--no-owner'
    pg_dump_cmd << '--encoding UTF8'
    pg_dump_cmd << '--inserts'
    pg_dump_cmd << '--no-privileges'
    pg_dump_cmd << '--no-tablespaces'
    pg_dump_cmd << "--file #{backup_file}"
    pg_dump_cmd << db_conf['database']

    pg_dump_cmd = pg_dump_cmd.join(' ')

    Rails.logger.info("Database dump command:")
    Rails.logger.info(pg_dump_cmd)

    `#{pg_dump_cmd}`

    Rails.logger.info("Database dump complete")
    Rails.logger.info("\n\n")
  end
end
