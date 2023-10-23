import Debug "mo:base/Debug";
import List "mo:base/List";

actor DKeeper {

  // Define a type for notes
  type Note = {
    title: Text;
    content: Text;
  };

  // Use a private stable variable to store notes
  private stable var notes: List.List<Note> = List.nil<Note>();

  // Create a note and add it to the list
  public func createNote(noteTitle: Text, noteContent: Text) : async () {
    let newNote: Note = {
      title = noteTitle;
      content = noteContent;
    };
    
    // Use try/catch for error handling
    try {
      notes := List.push(newNote, notes);
      Debug.print("Note created: ", newNote.title);
    } catch (err) {
      Debug.print("Error creating note: ", err);
    }
  };

  // Read all notes
  public query func readNotes(): async [Note] {
    return List.toArray(notes);
  };

  // Remove a note by its index
  public func removeNote(id: Nat) : async () {
    if (id < List.length(notes)) {
      let listFront = List.take(notes, id);
      let listBack = List.drop(notes, id + 1);
      notes := List.append(listFront, listBack);
      Debug.print("Note removed at index ", id);
    } else {
      Debug.print("Invalid note index");
    }
  }
}
