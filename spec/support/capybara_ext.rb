def click_icon(type)
  find(".icon-#{type}").click
end

def targetted_select2(value, options)
  find(options[:from]).find('a').click
  select_select2_result(value)
end

def select_select2_result(value)
  sleep(1)
  page.execute_script(%Q{$("div.select2-result-label:contains('#{value}')").mouseup()})
end
