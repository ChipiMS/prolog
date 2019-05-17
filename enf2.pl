archivo :-
	asserta(enfe("gripe",["tos","moco"])),
	asserta(enfe("asma",["moco_bronquial","tos"])),
	asserta(enfe("disnea",["tos","hiperinflacion"])),
	asserta(enfe("bronquitis",["moco_bronquial","fiebre"])),
	asserta(enfe("enfisema",["fiebre","tos","hiperinflacion"])),
	asserta(enfe("tosferina",["fiebre","tos"])),
	asserta(enfe("anemia",["fiebre","tos"])),
	save(enfdbs).

save(FileName) :-
	tell(FileName),listing,told.
