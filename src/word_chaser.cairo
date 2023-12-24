#[starknet::interface]
trait wordchaserTrait<TContractState> {
    fn register_player(ref self: TContractState, username: felt252);
    fn create_unknown_word(self: @TContractState, example:felt252, meaning:felt252, word:felt252);
    fn get_letters(ref self: TContractState, key:u128) -> Array<Letter>;
    fn display_progress(ref self: TContractState, key:u128) -> Letter;
}

#[starknet::contract]
mod WordChaser {
    use core::array::ArrayTrait;
    use starknet::ContractAddress;
    use starknet::get_caller_address;
    use core::debug::PrintTrait;

    #[storage]
    struct Storage {
        completed: LegacyMap<u128, CompletedWord>, 
        letters: LegacyMap<u128, Letter>,
        letters_count: u128,
        vocabulary: LegacyMap<u128, Vocabulary>,
        player: LegacyMap<u128, Player>,
        player_count: u128
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Info {
        info: felt252,
        description: felt252,
        method: felt252
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Vocabulary {
        example: felt252,
        meaning: felt252,
        word: felt252
    }

    #[derive(Drop)]
    enum Status {
        Completed,
        Inprogress,
        Failed,
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Letter {
        letter: felt252,
        is_revealed: bool
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct CompletedWord {
        word: felt252,
        status: felt252,
        trials_completed_at: felt252,
        completed_at: felt252
    }

    #[derive(Copy, Drop, Serde, starknet::store)]
    struct Player {
        userid: ContractAddress,
        username: felt252
        guess: felt252,
        word_progress: felt252,
        turns: u128,
        // is_revealed: bool
    }

    #[external(v0)]
    impl wordchaserImpl of super::wordchaserTrait<ContractState> {
        fn register_player(ref self: TContractState, username: felt252) {
            let player_id: ContractAddress = get_caller_address();
            let player: Player = Player {
                id: player_id, username: username, guess: guess, word_progress: word_progress,turns: 0
            };
            self.player_count.write(self.player_count.read() + 1);
            self.player.write(self.player_count.read(), player);
        }

        fn get_letters(ref self:@TContractState, key:u128) -> Array<Letter> {
            let mut letters = ArrayTrait::<Letter>::new();
            let total_letters = self.letters_count.read();
            let mut count = 1;

            if total_letters > 0 {
                loop {
                    let letterz = self.letters.read(count);
                    letter.append(letterz);
                    count += 1;
                    if count > total_letters {
                        break;
                    }
                };
            }
            letters
        }
    }
}