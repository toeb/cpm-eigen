find_package(Hg)

function(clone_hg_repo repo dir tag)



 set (error_code 1)
 set(number_of_tries 0)
 while(error_code AND number_of_tries LESS 3)

 
execute_process(
 COMMAND "${HG_EXECUTABLE}" clone "${repo}" "${dir}"
 RESULT_VARIABLE error_code
 
)
 math(EXPR number_of_tries "${number_of_tries} + 1")
 
 endwhile()
 if(number_of_tries GREATER 1)
  message(STATUS "had to hg clone mor than once: ${number_of_tries} times.")
 endif()
  if(error_code)
   message("Hg error for directory '${dir}'")
   message(FATAL_ERROR "Failed to clone repository '${repo}'")
   endif()

   execute_process(
   COMMAND "${HG_EXECUTABLE}" checkout "${tag}"

 	WORKING_DIRECTORY "${dir}"
   RESULT_VARIABLE error_code
)
if(error_code)
    message(FATAL_ERROR "Failed to checkout tag: '${tag}'")
  endif()

endfunction()

function(update_hg_repo dir tag)
 execute_process(
 COMMAND "${HG_EXECUTABLE}" update
 WORKING_DIRECTORY "${dir}"
 RESULT_VARIABLE error_code)

 if(error_code)
message("could not update hg repo in : '${dir}'")
 endif()

 execute_process(
 COMMAND "${HG_EXECUTABLE}" checkout "${tag}"
 WORKING_DIRECTORY "${dir}"
 RESULT_VARIABLE error_code
)

 if(error_code)
message(FATAL_ERROR "could not checkout sepcified tag: '${tag}'" )
 endif()



endfunction()

function(ensure_hg_repo_is_current repo dir tag)
  if(EXISTS "${dir}/")
    update_hg_repo(${dir} ${tag})
  else()
   clone_hg_repo(${repo} ${dir} ${tag})
  endif()
endfunction()
