enum InputType {
  date,
  time,
  text,
  textArea,
  selection,
  multiSelection,
}

const readOnlyTypes = [
  InputType.date,
  InputType.time,
  InputType.selection,
  InputType.multiSelection,
];

const selectBoxTypes = [
  InputType.selection,
  InputType.multiSelection,
];
