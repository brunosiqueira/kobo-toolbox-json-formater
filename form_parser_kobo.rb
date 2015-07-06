require 'spreadsheet'
require 'json'

excel = Spreadsheet.open ARGV[0]

choices = excel.worksheet(1)
survey = excel.worksheet(0)

survey_rows = survey.rows
choices_rows = choices.rows

survey_rows.shift
choices_rows.shift

def get_elements_from_list(id, choices_rows)
	array = []
  choices_rows.each do |row|
		if row[2].eql? id
			array << {label: row[0], name: row[1], order: row[3]}
		end
	end
	array
end

def build_question_answers(row, choices_rows)
	type_list = row[1].split(' ')
	unless type_list[1].nil?
    return get_elements_from_list(type_list[1], choices_rows)
  end
  return nil
end

def create_group(row, rows, choices_rows)

  forms = []
  create_content(rows, forms, choices_rows)
  {name: row[0] ,type: row[1], label: row[2], content: forms}
end

def create_question(row, choices_rows)
  question = {
      name: row[0],
      type: row[1],
      label: row[2]
  }

  if list = build_question_answers(row, choices_rows)
    question[:list] = list
  end
  question
end

def create_content(rows, forms, choices_rows)
  row = rows.shift
  if ["end group", "start", "end"].include?(row[1])
    return
  elsif row[1].eql? "begin group"
    forms << create_group(row, rows, choices_rows)
  elsif !["end group", "start", "end"].include?(row[1])
    forms << create_question(row, choices_rows)
  end
  create_content(rows,  forms, choices_rows)
end


forms = []
create_content(survey_rows, forms, choices_rows);

out = File.new ARGV[1], 'w+'
out.write JSON.generate(forms)
out.close


