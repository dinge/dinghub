class Graph8

  class << self

    def neo4j
      Neo4j::Session
    end

    def all_relationship_types
      neo4j.query.match('n-[r]->()').pluck('DISTINCT TYPE(r)')
    end

  end

end


      # @nodes = neo4j_query.match(n: params[:filter]).where("n:`#{model_klass_name_space}`").return(:n).map(&:n)
      #   neo4j_query.match(:n).pluck('DISTINCT labels(n) AS labels').flatten.uniq.sort

    # def all_relationships
    #   query =
    #     " MATCH n-[r]->()
    #       WITH distinct type(r) AS e
    #       RETURN e "
    #   neo4j.query(query).map(&:e)
    # end

