class PhxErxNode

    def initialize nsName, nodeList, model, attribute

      @node =nodeList.inject("/") do |nodeListString, name|
        nodeListString << "/" << nsName << ":" << name
        nodeListString
      end

      @model = model
      @attribute = attribute

    end

end
