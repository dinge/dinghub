# see Rake::Task['neo4j:reset_yes_i_am_sure'].invoke('test')

def neo4j_test_database_path
  Rails.root.join('db', 'neo4j', 'test')
end

def start_neo4j_test_database
  %x[#{neo4j_test_database_path}/bin/neo4j start]
end

def stop_neo4j_test_database
  %x[#{neo4j_test_database_path}/bin/neo4j stop]
end

def reset_neo4j_test_database
  path = neo4j_test_database_path
  if Dir.exists?(path)
    FileUtils.rm_rf(path.join('data/graph.db'))
    FileUtils.mkdir(path.join('data/graph.db'))
    FileUtils.rm_rf(path.join('data/log'))
    FileUtils.mkdir(path.join('data/log'))
  end
end
