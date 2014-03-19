class Pry::Command::ListPrompts < Pry::ClassCommand
  PROMPT_MAP = {
    "default" => {
      value: Pry::DEFAULT_PROMPT,
      description: "the default pry prompt"
    },

    "simple" => {
      value: Pry::SIMPLE_PROMPT,
      description: "a simple prompt"
    },

    "nav" => {
      value: Pry::NAV_PROMPT,
      description: "a prompt that draws the binding stack as a path and includes information about _in_ and _out_"
    },

    "none" => {
      value: Pry::NO_PROMPT,
      description: "wave goodbye to the pry prompt"
    }
 }

  match 'list-prompts'
  group 'prompts'
  description 'list the prompts available for use in pry'
  banner <<-BANNER
    Usage: list-prompts
    list the prompts available for use in pry
  BANNER

  def process
    output.puts heading("Available prompts") + "\n"
    PROMPT_MAP.each do |name, prompt|
      output.write "name: #{text.bold(name)}"
      output.puts selected_prompt?(prompt) ? selected_text : ""
      output.puts "#{prompt[:description]}"
      output.puts
    end
  end

private
  def selected_text
    text.red " (selected) "
  end

  def selected_prompt?(prompt)
    _pry_.prompt == prompt[:value]
  end

  Pry::Commands.add_command(self)
end
