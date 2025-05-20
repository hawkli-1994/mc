#!/usr/bin/perl
use strict;
use warnings;
use File::Find;

# 递归处理当前目录下的所有文件
find(\&process_file, '.');

sub process_file {
    my $file = $File::Find::name;

    # 跳过目录和非文本文件（可根据需要调整）
    return if -d $file;
    return unless -T $file;

    # 读取文件内容
    open(my $in, '<', $file) or die "无法打开文件 $file: $!";
    local $/;  # 一次性读取整个文件
    my $content = <$in>;
    close($in);

    # 执行替换
    $content =~ s/github\.com\/minio\/mc/github.com\/hawkli-1994\/mc/g;

    # 写回文件
    open(my $out, '>', $file) or die "无法写入文件 $file: $!";
    print $out $content;
    close($out);

    print "已处理: $file\n";
}