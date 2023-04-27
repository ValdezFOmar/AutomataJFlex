import os
import random

LIST_PATH = os.path.join('utils','kws_list.txt')
INPUT_PATH = os.path.join('input.txt')

# Get all the words and put them in a list
def get_words():
    kws = []
    with open(LIST_PATH, 'r') as f:
        for line in f:
            kws.append(line.strip('\n'))
        f.close()
    return kws

def write2input(wordsList):
    # Delete all the content in the file
    with open(INPUT_PATH, 'w') as f:
        f.write('')
        f.close
    # Write the words to the file
    with open(INPUT_PATH, 'a') as f:
        for word in wordsList:
            f.write(word + '\n')
        f.close()

def main():
    words = get_words()
    # random.shuffle(words)
    write2input(words)
    print('Words writed to file.')

if __name__ == '__main__':
    main()
