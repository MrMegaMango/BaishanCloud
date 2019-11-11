#! /bin/bash
jekyll b -s . -d dist || exit 1

cp .gitignore dist/ || exit 1

git add --force dist || exit 1
tree=$(git write-tree --prefix=dist/) || exit 1

echo tree is $tree

commit=$(
{
cat <<-END
Build release-baishan
END
} | git commit-tree $tree -p release-baishan
) || exit 1

echo commit is $commit

git update-ref refs/heads/release-baishan $commit || exit 1

git reset --hard HEAD

echo "successfully build branch release-baishan. you'll need to push release-baishan"
